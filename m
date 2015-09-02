From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:02:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next rc1 03/10] fm10k: don't
	store	sw_vid at reset
In-Reply-To: <1435178090-25422-4-git-send-email-jacob.e.keller@intel.com>
References: <1435178090-25422-1-git-send-email-jacob.e.keller@intel.com>
 <1435178090-25422-4-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B53C0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Wednesday, June 24, 2015 1:35 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH net-next rc1 03/10] fm10k: don't store sw_vid at reset

If we store the sw_vid at reset of PF, then we accidentally prevent the VF from receiving the message to update its default VID. This can occur if VFs are created before the PF is brought up, such as before ip link set <device> up.

This fixes an issue where we request the incorrect MAC/VLAN combinations, and prevents us from accidentally reporting some frames as vlan tagged.

-rc1
* Fixed up patch description

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
