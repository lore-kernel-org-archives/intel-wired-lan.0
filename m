From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:39:16 +0000
Subject: [Intel-wired-lan] [PATCH v1 7/9] fm10k: use different name
	than	FM10K_VLAN_CLEAR for override bit
In-Reply-To: <1459552659-22959-8-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-8-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E273714AB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 7/9] fm10k: use different name than FM10K_VLAN_CLEAR for override bit

Use a new #define FM10K_VLAN_OVERRIDE even though we're using the exact same bit. The reason for this is clarity in the code, otherwise you can read FM10K_VLAN_CLEAR and think it should be removed. Also add a comment explaining why the FM10K_VLAN_OVERRIDE bit is set.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

