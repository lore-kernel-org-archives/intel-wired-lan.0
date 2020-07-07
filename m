From: Andre Guedes <andre.guedes@intel.com>
Date: Tue,  7 Jul 2020 16:47:56 -0700
Subject: [Intel-wired-lan] [PATCH ethtool 0/4] Add support for IGC driver
Message-ID: <20200707234800.39119-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

This patch series adds support for parsing registers dumped by the IGC driver.
For now, the following registers are parsed:

	* Receive Address Low (RAL)
	* Receive Address High (RAH)
	* Receive Control (RCTL)
	* VLAN Priority Queue Filter (VLANPQF)
	* EType Queue Filter (ETQF)

More registers should be parsed as we need/enable them.

Cheers,
Andre

Andre Guedes (4):
  Add IGC driver support
  igc: Parse RCTL register fields
  igc: Parse VLANPQF register fields
  igc: Parse ETQF registers

 Makefile.am |   3 +-
 ethtool.c   |   1 +
 igc.c       | 283 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 internal.h  |   3 +
 4 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 igc.c

-- 
2.26.2

