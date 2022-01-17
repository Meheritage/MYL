using Microsoft.Office.Interop.Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.OleDb;

/// <summary>
/// Summary description for CreateExcelDocs
/// </summary>
public class CreateExcelDocs
{
    private Microsoft.Office.Interop.Excel.Application app = null;
    private Microsoft.Office.Interop.Excel.Workbook workbook = null;
    private Microsoft.Office.Interop.Excel.Worksheet worksheet = null;
    private Microsoft.Office.Interop.Excel.Range workSheet_range = null;
    public CreateExcelDocs()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public Workbook createDoc()
    {
        //try
        //{
        app = new Microsoft.Office.Interop.Excel.Application();
        //  app.Visible = true;
        workbook = app.Workbooks.Add(1);
        worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.Sheets[1];
        worksheet.Activate();

        //}
        //catch (Exception e)
        //{
        Console.Write("Error");
        //}
        return workbook;
    }
    public void createHeaders(int row, int col, string htext, bool font, int size, string fcolor, string cell1, string cell2)
    {
        worksheet.Cells[row, col] = htext;
        workSheet_range = worksheet.get_Range(cell1, cell2);
        workSheet_range.Font.Bold = font;
        workSheet_range.ColumnWidth = size;
    }
    public void addData(int row, int col, string data, string cell1, string cell2, string format)
    {
        worksheet.Cells[row, col] = data;
        workSheet_range = worksheet.get_Range(cell1, cell2);
        workSheet_range.Borders.Color = System.Drawing.Color.Black.ToArgb();
        workSheet_range.NumberFormat = format;
    }

    public void Close()
    {
        workbook.Close();
    }


    public System.Data.DataSet OpenExcel(string filepath)
    {
        System.Data.DataTable dtError = new System.Data.DataTable();
        dtError.Columns.Add("RowNo");
        dtError.Columns.Add("Description");
        DataRow drerrorow;
        app = new Microsoft.Office.Interop.Excel.Application();
        workbook = app.Workbooks.Open(filepath, 0, true, 5, "", "", true, Microsoft.Office.Interop.Excel.XlPlatform.xlWindows, "\t", false, false, 0, true, 1, 0);
        worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.Sheets[1];
        Microsoft.Office.Interop.Excel.Range xlRange = worksheet.UsedRange;
        System.Data.DataTable dtExcel = CreateExcelToDatatable(filepath);
        int rowCount = xlRange.Rows.Count;
        int colCount = xlRange.Columns.Count;
        int rowIndex = 2;
        int dtrow = 0;
        DataRow row;
        for (int ex = 2; ex <= rowCount; ex++)
        {
            row = dtExcel.NewRow();
            drerrorow = dtError.NewRow();
            dtExcel.Rows.Add(row);
            string insurancecardno = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)worksheet.Cells[rowIndex, 33]).Value2);
            if (!string.IsNullOrEmpty(insurancecardno))
            {
                dtExcel.Rows[dtrow]["InsuaranceCardNo"] = insurancecardno;
            }
            else
            {
                drerrorow["RowNo"] = rowIndex.ToString();
                drerrorow["Description"] = "Insurance card no not available";
                dtError.Rows.Add(drerrorow);
            }
            dtExcel.Rows[dtrow]["Empseq"] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)worksheet.Cells[rowIndex, 34]).Value2);
            dtExcel.Rows[dtrow]["DepnSeq"] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)worksheet.Cells[rowIndex, 35]).Value2);
            dtExcel.Rows[dtrow]["applseq"] = Convert.ToString(((Microsoft.Office.Interop.Excel.Range)worksheet.Cells[rowIndex, 36]).Value2);
            dtrow++;
            rowIndex++;
        }
        DataSet ds = new DataSet();
        ds.Tables.Add(dtExcel);
        ds.Tables.Add(dtError);
        return ds;
    }

    public System.Data.DataTable CreateExcelToDatatable(string fileName)
    {
        System.Data.DataTable dt = new System.Data.DataTable();
        dt.Columns.Add("InsuaranceCardNo");
        dt.Columns.Add("Empseq");
        dt.Columns.Add("DepnSeq");
        dt.Columns.Add("applseq");
        return dt;
    }

}