From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Tue, 12 Jan 2016 17:15:48 +0000
Subject: [Intel-wired-lan] [next PATCH S24 04/12] i40e: X722
	changes	to	access nvm
In-Reply-To: <D2CB76B6BECC8945A41B7D7368481CE6010A1FEA@ORSMSX111.amr.corp.intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-5-git-send-email-deepthi.kavalur@intel.com>
 <D2CB76B6BECC8945A41B7D7368481CE6010A1FEA@ORSMSX111.amr.corp.intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED16782897CCF6@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Tuesday, December 22, 2015 2:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S24 04/12] i40e: X722 changes to access
> nvm
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 does not have access to SRCTL registers, it has to do this through the AQ.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
[Sullivan, Catherine] 

Jeff, please drop this patch, it introduces a bug. 
