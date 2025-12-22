/*
 Name: Scott Macioce
 Course: CSD430 - Server-Side Development
 Assignment: Module 12 - Module 4 Rework
 Purpose: JavaBean to represent a Tolkien book record for display in a JSP table
*/

package csd430;

import java.io.Serializable;

public class TolkienBook implements Serializable {

    private static final long serialVersionUID = 1L;

    // Minimum of 5 fields
    private String title;
    private String series;
    private int publicationYear;
    private String format;
    private int pages;
    private String mainSetting;

    // No-arg constructor
    public TolkienBook() { }

    // Convenience constructor
    public TolkienBook(String title, String series, int publicationYear, String format, int pages, String mainSetting) {
        this.title = title;
        this.series = series;
        this.publicationYear = publicationYear;
        this.format = format;
        this.pages = pages;
        this.mainSetting = mainSetting;
    }

    // Getters/Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getSeries() { return series; }
    public void setSeries(String series) { this.series = series; }

    public int getPublicationYear() { return publicationYear; }
    public void setPublicationYear(int publicationYear) { this.publicationYear = publicationYear; }

    public String getFormat() { return format; }
    public void setFormat(String format) { this.format = format; }

    public int getPages() { return pages; }
    public void setPages(int pages) { this.pages = pages; }

    public String getMainSetting() { return mainSetting; }
    public void setMainSetting(String mainSetting) { this.mainSetting = mainSetting; }
}
