From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 23 Dec 2016 20:59:59 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not disable FEC from the
 driver
In-Reply-To: <20160928230148.7162.97867.stgit@localhost6.localdomain6>
References: <20160928230148.7162.97867.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E491036EC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Emil Tantilov
Sent: Wednesday, September 28, 2016 4:02 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: do not disable FEC from the driver

FEC is configured by the NVM and the driver should not be overriding it.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

