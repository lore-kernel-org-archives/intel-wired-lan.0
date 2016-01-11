From: Kavalur, Deepthi <deepthi.kavalur@intel.com>
Date: Mon, 11 Jan 2016 21:15:15 +0000
Subject: [Intel-wired-lan] [next PATCH S24 04/12] i40e: X722 changes
	to	access nvm
In-Reply-To: <1450823114-29514-5-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
 <1450823114-29514-5-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <D2CB76B6BECC8945A41B7D7368481CE6010A1FEA@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch should be dropped as it may introduce a bug. Another patch containing the fix is already submitted with subject:
"[v2,next,S23,9/13] i40e: Make some changes in the nvm read code"

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Deepthi Kavalur
Sent: Tuesday, December 22, 2015 2:25 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [next PATCH S24 04/12] i40e: X722 changes to access nvm

From: Anjali Singhai Jain <anjali.singhai@intel.com>

X722 does not have access to SRCTL registers, it has to do this through the AQ.
