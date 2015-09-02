From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:18:59 +0000
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: update netdev perm_addr
 during	reinit, instead of at up
In-Reply-To: <1434405656-10465-6-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
 <1434405656-10465-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B5600@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Monday, June 15, 2015 3:01 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: update netdev perm_addr during reinit, instead of at up

Update the netdev permanent address during fm10k_reinit enables the user to immediately see the new MAC address on the VF even if the device isn't up. The previous code required that the device by opened before changes would appear.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
