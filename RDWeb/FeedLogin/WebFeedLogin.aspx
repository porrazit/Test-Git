<%@ Page Language="C#" ContentType="application/x-msts-webfeed-login" Trace="false" %>
<script runat="server">
  protected void Page_Load(object sender, EventArgs e)
  {
      // Deny requests with "additional path information"
      if (Request.PathInfo.Length != 0)
      {
          Response.StatusCode = 404;
          Response.End();
      }

      string userIdentifier;
      if(HttpContext.Current.User.Identity is System.Security.Principal.WindowsIdentity)
      {
          // get SID from WindowsIdentity
          System.Security.Principal.WindowsIdentity identity = (System.Security.Principal.WindowsIdentity)HttpContext.Current.User.Identity;
          userIdentifier = identity.User.ToString();
      }
      else
      {
          userIdentifier = HttpContext.Current.User.Identity.Name;
      }

      FormsAuthenticationTicket ticket = 
                new FormsAuthenticationTicket(
                    0,                  // version 0
                    userIdentifier,
                    DateTime.UtcNow,
                    DateTime.MaxValue,
                    true,               // is persistent
                    String.Empty,     // No user data
                    VirtualPathUtility.GetDirectory(Request.FilePath));
                    
        Response.Write(FormsAuthentication.Encrypt(ticket));
    }
</script>        
