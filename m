From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 13 Apr 2016 22:37:07 +0000
Subject: [Intel-wired-lan] [PATCH v1 5/9] fm10k: fix documentation
	of	fm10k_tlv_parse_attr
In-Reply-To: <1459552659-22959-6-git-send-email-jacob.e.keller@intel.com>
References: <1459552659-22959-1-git-send-email-jacob.e.keller@intel.com>
 <1459552659-22959-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E27371482@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, April 1, 2016 4:18 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v1 5/9] fm10k: fix documentation of fm10k_tlv_parse_attr

fm10k_tlv_parse_attr is supposed to return FM10K_NOT_IMPLEMENTED for any TLV who's attribute id lies outside the range of results. It does not do this today. In addition, the documentation does not indicate that other attributes which are not implemented for a given TLV will be silently ignored. Fix this. Clean up the logic so that we don't rely on the fact that FM10K_NOT_IMPLEMENTED is greater than zero, as this can easily cause confusion.

A future extension could look into some way of reporting unknown TLVs in order to make issues more easily discoverable. We can't just return FM10K_NOT_IMPLEMENTED here because we don't want to drop the entire message if it has an unknown TLV.

While here, update the copyright year.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---


Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>

