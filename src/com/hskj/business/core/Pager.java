package com.hskj.business.core;

import java.util.ArrayList;
import java.util.List;

public class Pager
{
  protected int[] pageSizeList = { 5, 10, 25, 50, 100, 200, 500, 1000 };
  protected int pageSize = 10;
  protected int pageNo = 1;
  protected int rowCount = 0;
  protected int pageCount = 1;
  protected int startIndex = 1;
  protected int endIndex = 1;
  protected int firstPageNo = 1;
  protected int prePageNo = 1;
  protected int nextPageNo = 1;
  protected int lastPageNo = 1;
  protected List resultList;
  protected Object condition;
  protected String sql;
  protected String countSql;

  public String getCountSql()
  {
    return this.countSql;
  }

  public void setCountSql(String countSql) {
    this.countSql = countSql;
  }

  public String getSql() {
    return this.sql;
  }

  public void setSql(String sql) {
    this.sql = sql;
  }

  public Object getCondition() {
    return this.condition;
  }

  public void setCondition(Object condition) {
    this.condition = condition; }

  public Pager(int pageSize, int pageNo, int rowCount, List resultList) {
    this.pageSize = pageSize;
    this.pageNo = pageNo;
    this.rowCount = rowCount;
    this.resultList = resultList;

    if (rowCount % pageSize == 0)
      this.pageCount = (rowCount / pageSize);
    else
      this.pageCount = (rowCount / pageSize + 1);

    this.startIndex = (pageSize * (pageNo - 1));
    this.endIndex = (this.startIndex + resultList.size());

    this.lastPageNo = this.pageCount;
    if (this.pageNo > 1) this.prePageNo = (this.pageNo - 1);
    if (this.pageNo == this.lastPageNo)
      this.nextPageNo = this.lastPageNo;
    else
      this.nextPageNo = (this.pageNo + 1);
  }

  public Object[] getPageSizeIndexs()
  {
    boolean flag = true;
    List result = new ArrayList(this.pageSizeList.length);
    for (int i = 0; i < this.pageSizeList.length; ++i) {
      if (flag)
        if (this.pageSizeList[i] == this.pageSize) {
          flag = false;
        } else if (this.pageSizeList[i] > this.pageSize) {
          result.add(String.valueOf(this.pageSize));
          flag = false;
        }

      result.add(String.valueOf(this.pageSizeList[i]));
    }
    Object[] indexs = result.toArray();
    return indexs;
  }

  public Object[] getPageNoIndexs() {
    List result = new ArrayList(this.pageCount);
    for (int i = 0; i < this.pageCount; ++i) {
      result.add(String.valueOf(i + 1));
      if (i > 20) break;
    }
    Object[] indexs = result.toArray();
    return indexs;
  }

  public int getEndIndex() {
    return this.endIndex;
  }

  public void setEndIndex(int endIndex) {
    this.endIndex = endIndex;
  }

  public int getPageCount() {
    return this.pageCount;
  }

  public void setPageCount(int pageCount) {
    this.pageCount = pageCount;
  }

  public int getPageNo() {
    return this.pageNo;
  }

  public void setPageNo(int pageNo) {
    this.pageNo = pageNo;
  }

  public int getPageSize() {
    return this.pageSize;
  }

  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }

  public int[] getPageSizeList() {
    return this.pageSizeList;
  }

  public void setPageSizeList(int[] pageSizeList) {
    this.pageSizeList = pageSizeList;
  }

  public List getResultList() {
    return this.resultList;
  }

  public void setResultList(List resultList) {
    this.resultList = resultList;
  }

  public int getRowCount() {
    return this.rowCount;
  }

  public void setRowCount(int rowCount) {
    this.rowCount = rowCount;
  }

  public int getStartIndex() {
    return this.startIndex;
  }

  public void setStartIndex(int startIndex) {
    this.startIndex = startIndex;
  }

  public int getFirstPageNo() {
    return this.firstPageNo;
  }

  public void setFirstPageNo(int firstPageNo) {
    this.firstPageNo = firstPageNo;
  }

  public int getLastPageNo() {
    return this.lastPageNo;
  }

  public void setLastPageNo(int lastPageNo) {
    this.lastPageNo = lastPageNo;
  }

  public int getNextPageNo() {
    return this.nextPageNo;
  }

  public void setNextPageNo(int nextPageNo) {
    this.nextPageNo = nextPageNo;
  }

  public int getPrePageNo() {
    return this.prePageNo;
  }

  public void setPrePageNo(int prePageNo) {
    this.prePageNo = prePageNo;
  }
}