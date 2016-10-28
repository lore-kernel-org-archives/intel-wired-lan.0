From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Fri, 28 Oct 2016 11:42:45 -0400
Subject: [Intel-wired-lan] [net-next PATCH v2 0/4] Add support for XPS when
	using DCB
Message-ID: <20161028154126.67826.76735.stgit@ahduyck-blue-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series enables proper isolation between traffic classes when
using XPS while DCB is enabled.  Previously enabling XPS would cause the
traffic to be potentially pulled from one traffic class into another on
egress.  This change essentially multiplies the XPS map by the number of
traffic classes and allows us to do a lookup per traffic class for a given
CPU.

To guarantee the isolation I invalidate the XPS map for any queues that are
moved from one traffic class to another, or if we change the number of
traffic classes.

v2: Added sysfs to display traffic class
    Replaced do/while with for loop
    Cleaned up several other for for loops throughout the patch

---

Alexander Duyck (4):
      net: Move functions for configuring traffic classes out of inline headers
      net: Add sysfs value to determine queue traffic class
      net: Refactor removal of queues from XPS map and apply on num_tc changes
      net: Add support for XPS with QoS via traffic classes


 include/linux/netdevice.h |   36 +------
 net/core/dev.c            |  226 +++++++++++++++++++++++++++++++++++----------
 net/core/net-sysfs.c      |   51 ++++++++--
 3 files changed, 219 insertions(+), 94 deletions(-)

--
