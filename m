From: Vlad Zolotarov <vladz@cloudius-systems.com>
Date: Thu, 26 Mar 2015 19:56:37 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2]: ixgbe: Add the
	appropriate ethtool ops to query RSS indirection table and key
Message-ID: <1427392599-18184-1-git-send-email-vladz@cloudius-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ethtool ops to VF driver to allow querying the RSS indirection table
and RSS Random Key.

This series refactors the RSS configuration code to store the current contents of
RSS indirection table and Hash Key in the "adapter" struct so that we won't need
to access registers every time this info is queried.

Vlad Zolotarov (2):
  ixgbe: Refactor the RSS configuration code.
  ixgbe: Add the appropriate ethtool ops to query RSS indirection table
    and key

 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  42 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 143 ++++++++++++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   7 ++
 4 files changed, 152 insertions(+), 43 deletions(-)

-- 
2.1.0

