From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 23 Mar 2022 13:43:51 +0100
Subject: [Intel-wired-lan] [PATCH net 0/2] ice: avoid sleeping/scheduling in
 atomic contexts
Message-ID: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The `ice_misc_intr() + ice_send_event_to_aux()` infamous pair failed
once again.
Fix yet another (hopefully last one) 'scheduling while atomic' splat
and finally plug the hole to gracefully return prematurely when
invoked in wrong context instead of panicking.

Alexander Lobakin (2):
  ice: fix 'scheduling while atomic' on aux critical err interrupt
  ice: don't allow to run ice_send_event_to_aux() in atomic ctx

 drivers/net/ethernet/intel/ice/ice.h      |  2 ++
 drivers/net/ethernet/intel/ice/ice_idc.c  |  3 +++
 drivers/net/ethernet/intel/ice/ice_main.c | 25 ++++++++++++++---------
 3 files changed, 20 insertions(+), 10 deletions(-)

-- 
Urgent fix, would like to make it directly through -net.
-- 
2.35.1

