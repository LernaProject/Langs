using System;
using System.Security;
using System.Security.Permissions;
using System.Security.Policy;

public class Program {
    public static int Main(string[ ] args) {
        var pset = new PermissionSet(PermissionState.None);

        var io = new FileIOPermission(PermissionState.None);
        io.AllFiles = FileIOPermissionAccess.Read;
        pset.AddPermission(io);

        var ads = new AppDomainSetup();
        ads.ApplicationBase = "/tmp/test";

        var sandbox = AppDomain.CreateDomain("Sandbox", null, ads, pset);

        //Forward arguments to the program being executed.
        var newArgs = new string[args.Length - 1];
        for (int i = 0; i < newArgs.Length; i++)
            newArgs[i] = args[i + 1];
        return sandbox.ExecuteAssembly(args[0], newArgs);
    }
}
