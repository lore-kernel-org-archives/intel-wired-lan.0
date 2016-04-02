From: Alexander Duyck <aduyck@mirantis.com>
Date: Sat, 02 Apr 2016 00:03:13 -0700
Subject: [Intel-wired-lan] [next PATCH 0/2] Clean-up features and add
 support for IPIP and SIT tunnel offloads
Message-ID: <20160402070114.13504.22615.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to help pave the way for the GSO partial changes
that will likely be coming in a couple weeks.  The first patch resolves
some feature issues and makes it so that we can more easily see what
features are supported for each driver and which are not.  The second patch
adds support for IPIP and SIT tunnels where were already supported by the
hardware but were not enabled in the drivers.

---

Alexander Duyck (2):
      i40e/i40evf: Clean up feature flags
      i40e/i40evf: Add support for IPIP and SIT offloads


 drivers/net/ethernet/intel/i40e/i40e_main.c     |   63 +++++++++------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     |   24 +++++---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |   24 +++++---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   68 ++++++++++++-----------
 4 files changed, 94 insertions(+), 85 deletions(-)

--
