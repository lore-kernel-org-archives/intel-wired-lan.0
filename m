From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 17:39:27 +0000
Subject: [Intel-wired-lan] [next PATCH S25 08/16] i40e: add counter for
 arq	overflows
In-Reply-To: <1450901156-30904-9-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-9-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B581@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 08/16] i40e: add counter for arq
> overflows
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Sometimes, ARQ overflows are a big deal and tell us that the
> firmware/hardware/driver/something is having problems. But normally
> they're no big deal. To assist in assessing this, add a counter to our Ethtool
> stats. A handful of ARQ overflows during VF init is no problem. A large, ever-
> growing number indicates that Something Bad is happening.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, ethtool -S [devx] shows port.arq_overflows stat, stat counts correctly
