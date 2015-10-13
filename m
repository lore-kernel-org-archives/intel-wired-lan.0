From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 13 Oct 2015 12:05:32 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: fix 32 bit build warnings
In-Reply-To: <57023416.17EujnXPCo@wuerfel>
References: <6607276.TY67sbLLqL@wuerfel>
 <1444717101.2870.16.camel@intel.com> <57023416.17EujnXPCo@wuerfel>
Message-ID: <1444763132.2870.32.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-10-13 at 13:37 +0200, Arnd Bergmann wrote:
> This is the majority of all build warnings we get on allmodconfig
> (both i386 and arm),
> so it would be really nice to have it fixed before 4.3. For all I can
> tell, the
> patch still applies on your branch too, but see below for the rebased
> version.
> 
> I also note that your branch is not part of linux-next, is that
> intentional?
> 
>         Arnd

Huh are you sure you used by dev-queue branch?  I ask because this is
what I am getting when I try to apply your patch:

git am .apply/i40evf-fix-32-bit-build-warnings.patch
Applying: Jesse Brandeburg fixed a bug for 32-bit systems in the i40e
driver
error: patch failed:
drivers/net/ethernet/intel/i40evf/i40e_common.c:443
error: drivers/net/ethernet/intel/i40evf/i40e_common.c: patch does not
apply
Patch failed at 0001 Jesse Brandeburg fixed a bug for 32-bit systems in
the i40e driver
The copy of the patch that failed is found in:
   /home/jtkirshe/Public/next-queue/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[12:02:27 @jtkirshe-linux:next-queue]$ patch -p1 <.apply/i40evf-fix-32
-bit-build-warnings.patch 
patching file drivers/net/ethernet/intel/i40evf/i40e_common.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file
drivers/net/ethernet/intel/i40evf/i40e_common.c.rej
[12:02:52 @jtkirshe-linux:next-queue]$

Even looking@the code, the code your changing does not exist in my
dev-queue branch of my next-queue tree. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151013/61881730/attachment.asc>
