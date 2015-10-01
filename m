From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 19:13:57 +0000
Subject: [Intel-wired-lan] [next PATCH S16 12/15] i40e:
	Recognize	1000Base_T_Optical phy type when link is up
In-Reply-To: <1443463964-148204-13-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2CCB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 12/15] i40e: Recognize
> 1000Base_T_Optical phy type when link is up
> 
> 1000Base_T_Optical got added to the function that figures out what is
> supported when link is down but not when link is up. Add it in there too so
> that we display the correct information.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I85ebcdfa7c02d898c44c673b1500552a53c8042e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, correct link information shown in ethtool with 1000BaseT optical PHY
