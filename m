From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 19:00:12 +0000
Subject: [Intel-wired-lan] [next PATCH S24 12/12] i40e: add 100Mb
 ethtool	reporting
In-Reply-To: <1450823114-29514-13-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-13-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98019E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 12/12] i40e: add 100Mb ethtool
> reporting
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> Add some missing reporting/advertisement of 100Mb capability for adapters
> that support it.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I8b8523fbdc99517bec29d90c71b3744db11542ac
> ---
> Testing-Hints:
> Check that 100M SGMII is not listed as supported on X710 devices and is
> listed as supported on X722 devices.
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, does not break base driver
