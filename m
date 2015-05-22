From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Fri, 22 May 2015 15:07:33 +0000
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB4EE6@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB28F4@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FB5E4@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB3B4A@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FBBEC@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB4EE6@BPXM14GP.gisp.nec.co.jp>
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A07892F9481@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Hiroshi Shimamoto
> Sent: Thursday, May 21, 2015 7:31 PM
> To: Skidmore, Donald C; Kirsher, Jeffrey T; intel-wired-
> lan at lists.osuosl.org
> Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi, Sy
> Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> sassmann at redhat.com
> Subject: Re: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust
> VF
> 

[big snip]

> I think your concerns are related to some operational assumptions.
> My basic concept is, not to change the behavior of VM, existing user
> operation.
> I mean that I didn't think it's better that the user should check the both
> of the ixgbevf driver can deal with new API and the VF is trusted.
> 
> Now, I think the point is who takes care whether the VF is trusted. Right?
> It seems that you think the VF user should handle that user is trusted and
> do something with a notice that "you're trusted or untrusted" from the
> host.
> Is that correct?
> I made it in PF side, because it looks easy to handle it. If something to
> do in VF side, I think ixgbevf driver should handle it.

Setting the VF trusted mode feature should only be allowed through the PF as it is the only trusted entity from the start.  We do not want the VF being able to decide for itself to be trusted.

- Greg

> 
> thanks,
> Hiroshi
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
