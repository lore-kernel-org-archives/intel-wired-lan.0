From: Pujari, Bimmy <bimmy.pujari@intel.com>
Date: Wed, 7 Sep 2016 00:24:51 +0000
Subject: [Intel-wired-lan] [next PATCH S45 00/10] i40e/i40evf updates
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B6265026F241@ORSMSX102.amr.corp.intel.com>
References: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
 <9BBC4E0CF881AA4299206E2E1412B6265026F241@ORSMSX102.amr.corp.intel.com>
Message-ID: <B759292EEECB5C46AEDF3EC46470BC94AB5223@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Carolyn

No problem I will fix it. Anyways I have to send new version with new message for Harshitha & Lohong's patches.

Thanks
Bimmy
-----Original Message-----
From: Wyborny, Carolyn 
Sent: Tuesday, September 6, 2016 1:08 PM
To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: RE: [Intel-wired-lan] [next PATCH S45 00/10] i40e/i40evf updates

Hello Bimmy,

The "g" on the end of Lihong's last name is missing.  8-)

Thanks,

Carolyn

> -----Original Message-----
> From: Intel-wired-lan 
> [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Bimmy 
> Pujari
> Sent: Tuesday, September 06, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S45 00/10] i40e/i40evf updates
> 
> Alexander Duyck adds code to limit TX descriptor count in cases where 
> frag size is greater than 16K.
> 
> Bimmy Pujari removes unnecessary error checking against i40evf_up_complete.
> 
> Alan Brady adds code to fix deleting mac filters.
> 
> Harshitha Ramamurthy removes 100 Mbps SGMII support for X722.
> 
> Henry Tieman removes unreachable code.
> 
> Jacob Keller adds code to cleanup ATR auto_disable_flags use & checks 
> conflicting ntuple/sideband rules when re-enabling ATR.
> 
> Lihong Yan removes unnecessary error checking against 
> i40e_shutdown_adminq.
> 
> Preethi Banala adds encap csum VF offload flag.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    |  3 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c       | 43 ++++++++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 21 +++++------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |  7 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c   | 16 +++------
>  7 files changed, 39 insertions(+), 53 deletions(-)
> 
> --
> 2.4.11
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
