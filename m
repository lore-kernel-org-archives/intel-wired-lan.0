From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Tue, 15 May 2018 17:30:03 +0000
Subject: [Intel-wired-lan] Does a VF know that it is "trusted"?
In-Reply-To: <51a0f92e-7b0e-e657-fcd8-b636ff8b7937@oracle.com>
References: <51a0f92e-7b0e-e657-fcd8-b636ff8b7937@oracle.com>
Message-ID: <F6FB0E698C9B3143BDF729DF22286646C4D7B0F0@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

For ixgbevf at least it isn't told it is "trusted" or not.  But you could ask for something that would require it to be and based on the reply you should be able to infer.  

-Don

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Shannon Nelson
> Sent: Tuesday, May 15, 2018 10:24 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] Does a VF know that it is "trusted"?
> 
> If the admin has set the trusted attribute on a VF, e.g.
> 	ip link set dev eth4 vf 1 trust on
> does the vf know it is trusted?
> 
> Is there an accepted (and simple?) way for the VF to check for its trust level?
> 
> sln
> --
> ==================================================
> Shannon Nelson           shannon.nelson at oracle.com
> Parents can't afford to be squeamish
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
