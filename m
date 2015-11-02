From: Miller, Darin J <darin.j.miller@intel.com>
Date: Mon, 2 Nov 2015 22:52:57 +0000
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Update PTP to support
 X550EM_x	devices
In-Reply-To: <20151027165807.108282.20831.stgit@mdrustad-wks.jf.intel.com>
References: <20151027165807.108282.20831.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D37520FAF1@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Tuesday, October 27, 2015 9:58 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: Update PTP to support X550EM_x devices

The X550EM_x devices handle clocking differently, so update the PTP implementation to accommodate them. This involves signicant changes to ixgbe's PTP code to accommodate the new range of behaviors including things like non-power-of-2 clock wrapping.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Tested-by: Darin Miller <darin.j.miller@intel.com>

