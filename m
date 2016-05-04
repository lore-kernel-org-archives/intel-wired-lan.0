From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 May 2016 16:06:04 +0000
Subject: [Intel-wired-lan] [next PATCH S36 05/12] i40e: lie to the VF
In-Reply-To: <1462313600-3123-6-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D599D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, May 03, 2016 3:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S36 05/12] i40e: lie to the VF
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If an untrusted VF attempts to configure promiscuous mode, log a message
> pointing out its naughty behavior. But then, instead of returning an error to
> the offender, just lie to it and say everything's OK. It will continue on its way,
> thinking it's in promiscuous mode, but receiving no packets except its own.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I63369215b1720f3c531eedfc06af86ff8c0e3dc8
> ---
> Testing Hints : Configure promiscuous mode on a non-trusted VF and
> observe the results. Make sure trusted VFs still work.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Promisc mode only actually works on trusted VFs as expected. Naughty behavior logged in dmesg if attempt is made on untrusted VF
