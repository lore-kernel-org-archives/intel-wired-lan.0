From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 16 Feb 2022 16:51:34 -0800
Subject: [Intel-wired-lan] [net PATCH 0/2] ice/i40e: stop disabling VFs due
 to PF error responses
Message-ID: <20220217005136.75627-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice and i40e drivers have similar logic to detect PF error responses to
the VFs over the Virtchnl interface. This logic counts the number of
sequential error responses sent to a VF and logs each error response as a
dev_info to the kernel log. If more than 10 error responses are sent in a
row, the PF driver disables the VF in question.

This logic has existed since the early days of i40e VF implementation, and
was carried forward into ice. The logic appears to be some form of malicious
VF detection. However, it doesn't actually fit in with the hardware based
malicious VF detection available in the device hardware.

In fact, the logic has had some adjustments in the i40e driver to reduce the
messaging from dev_err to dev_info, and to allow specific messages to skip
the check.

These changes clearly highlight the problematic nature of the check.
Additionally, there is no requirement for this behavior in our product
design. Other driver implementations such as the FreeBSD drivers do not
implement this behavior.

Disabling VFs is typically not what system administrators what to happen,
and this behavior is non-intuitive and not documented. Since it clearly
causes issues and isn't connected to the proper malicious driver detection,
remove this check from both ice and i40e.

Jacob Keller (2):
  i40e: stop disabling VFs due to PF error responses
  ice: stop disabling VFs due to PF error responses

 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  6 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 57 +++----------------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  5 --
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 18 ------
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  3 -
 5 files changed, 9 insertions(+), 80 deletions(-)


base-commit: 35410c10918a84c9685cd644686ca637bb3c046b
-- 
2.35.1.129.gb80121027d12

