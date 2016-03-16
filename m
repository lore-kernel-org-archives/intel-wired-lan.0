From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Mar 2016 18:12:00 +0000
Subject: [Intel-wired-lan] Latest dev-queue pull has i40e VFs
	reporting	"Device still in reset"
In-Reply-To: <CAKgT0Ue=36RUVBkDJ0scqCwFEph8JOJmBqaD2MiY+CDvj3mpuQ@mail.gmail.com>
References: <CAKgT0Ue=36RUVBkDJ0scqCwFEph8JOJmBqaD2MiY+CDvj3mpuQ@mail.gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D5B1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'm not seeing the reset, but I get a permission denied error trying to echo 4 to /sys/class/net/[device]/device/sriov_numvfs and an ls of the directory shows no sriov_numvfs file present... I can do it with my ixgbe device, but not my i40e device.  I went back to a few different kernels from earlier this week, last week, and the week before with the same results. Since I know it WAS working earlier, I tried the stock kernel and get "no such file or directory"... I'm thinking it's an issue with my card, although I wonder if yours is related. I'll try a few things with mine and see if I get anywhere.

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, March 16, 2016 10:21 AM
> To: e1000-devel at lists.sourceforge.net; intel-wired-lan <intel-wired-
> lan at lists.osuosl.org>
> Subject: [Intel-wired-lan] Latest dev-queue pull has i40e VFs reporting
> "Device still in reset"
> 
> So my system with the latest pull of the dev-queue branch is stuck reporting
> "Device is still in reset (-16), retrying" for one or more VFs after I reload the
> drivers.  I've been trying to bisect the issue but haven't been having much
> luck.
> 
> Just wanted to see if anyone in Intel was aware of the issue, otherwise I will
> probably re-run my bisection with a full system reset between patches as I
> suspect I may be having issues reproducing it due to stray data being left in
> from earlier driver loads.
> 
> - Alex
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
