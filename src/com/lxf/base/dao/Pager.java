package com.lxf.base.dao;

public class Pager
{
  private int totalRows;
  private int pageSize = 15;
  private int currentPage = 1;
  private int totalPages;
  private int startRow = 0;
  private int endRow = this.startRow + this.pageSize;
  private String pagerMethod = "";

  public Pager()
  {
  }

  public Pager(int totalRows)
  {
    setPager("1", this.pageSize, "", totalRows);
  }

  public Pager(String currentPage, String pagerMethod, int totalRows)
  {
    setPager(currentPage, this.pageSize, pagerMethod, totalRows);
  }

  public Pager(String currentPage, int pageSize, String pagerMethod, int totalRows)
  {
    setPager(currentPage, pageSize, pagerMethod, totalRows);
  }

  private void setPager(int _totalRows) {
    this.totalRows = _totalRows;
    this.totalPages = (this.totalRows / this.pageSize);
    int mod = this.totalRows % this.pageSize;
    if (mod > 0) {
      this.totalPages += 1;
    }
    this.currentPage = 1;
    this.startRow = 0;
  }
  private void setPager(int _totalRows, int _pageSize) {
    this.pageSize = _pageSize;

    this.totalRows = _totalRows;
    this.totalPages = (this.totalRows / this.pageSize);
    int mod = this.totalRows % this.pageSize;
    if (mod > 0) {
      this.totalPages += 1;
    }
    this.currentPage = 1;
    this.startRow = 0;
  }

  public void setPager(String currentPage, int pageSize, String pagerMethod, int totalRows)
  {
    currentPage = (currentPage == null) || (currentPage.equals("")) ? "1" : currentPage;
    pagerMethod = pagerMethod == null ? "" : pagerMethod;

    setPager(totalRows, pageSize);

    if ((currentPage != null) && (!currentPage.equals("0"))) {
      refresh(Integer.parseInt(currentPage));
      refresh();
    }

    if (pagerMethod != null)
      if (pagerMethod.equals("first"))
        first();
      else if (pagerMethod.equals("previous"))
        previous();
      else if (pagerMethod.equals("next"))
        next();
      else if (pagerMethod.equals("last"))
        last();
      else if (pagerMethod.equals("refresh"))
        refresh();
  }

  public int getStartRow()
  {
    return this.startRow;
  }
  public int getTotalPages() {
    return this.totalPages;
  }
  public int getCurrentPage() {
    return this.currentPage;
  }
  public int getPageSize() {
    return this.pageSize;
  }

  public void setTotalRows(int totalRows)
  {
    this.totalRows = totalRows;
    setPager(String.valueOf(this.currentPage), this.pageSize, this.pagerMethod, totalRows);
  }

  public void setStartRow(int startRow) {
    this.startRow = startRow;
  }
  public void setTotalPages(int totalPages) {
    this.totalPages = totalPages;
  }
  public void setCurrentPage(int currentPage) {
    this.currentPage = currentPage;
  }
  public void setPageSize(int pageSize) {
    this.pageSize = pageSize;
  }
  public int getTotalRows() {
    return this.totalRows;
  }

  public String getPagerMethod() {
    return this.pagerMethod;
  }
  public void setPagerMethod(String pagerMethod) {
    this.pagerMethod = pagerMethod;
  }

  public void first() {
    this.currentPage = 1;
    this.startRow = 0;
    this.endRow = (this.startRow + this.pageSize);
  }
  public void previous() {
    if ((this.currentPage == 1) || (this.currentPage == 0)) {
      return;
    }
    this.currentPage -= 1;
    this.startRow = ((this.currentPage - 1) * this.pageSize);
    this.endRow = (this.startRow + this.pageSize);
  }
  public void next() {
    if (this.currentPage < this.totalPages) {
      this.currentPage += 1;
    }
    this.startRow = ((this.currentPage - 1) * this.pageSize);
    this.endRow = (this.startRow + this.pageSize);
  }
  public void last() {
    this.currentPage = this.totalPages;
    this.startRow = ((this.currentPage - 1) * this.pageSize);
    this.endRow = (this.startRow + this.pageSize);
  }
  public void refresh(int _currentPage) {
    this.currentPage = _currentPage;
    if (this.currentPage > this.totalPages)
      last();
  }

  public void refresh() {
    this.startRow = ((this.currentPage - 1) * this.pageSize);
    this.endRow = (this.startRow + this.pageSize);
  }

  public int getEndRow() {
    return this.endRow;
  }

  public void setEndRow(int endRow) {
    this.endRow = endRow;
  }
}