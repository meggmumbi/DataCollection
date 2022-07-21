using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace CicPortal
{

    public class FileUploadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    string filePath = Config.FilesLocation() + "UploadFiles/";
                    HttpPostedFile file = files[i];
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = filePath + file.FileName;
                    file.SaveAs(fileName);
                }
                context.Response.ContentType = "application/octet-stream";
                context.Response.Write("File Uploaded Successfully!");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
