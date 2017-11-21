From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 21 Nov 2017 09:37:58 -0800
Subject: [Intel-wired-lan] [PATCH v2 3/7] ixgbevf: Use smp_rmb rather
 than read_barrier_depends
In-Reply-To: <1510938349-17608-4-git-send-email-brking@linux.vnet.ibm.com>
References: <1510938349-17608-1-git-send-email-brking@linux.vnet.ibm.com>
 <1510938349-17608-4-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <20171121093758.00007ad6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 17 Nov 2017 11:05:45 -0600
Brian King <brking@linux.vnet.ibm.com> wrote:

> The original issue being fixed in this patch was seen with the ixgbe
> driver, but the same issue exists with ixgbevf as well, as the code is
> very similar. read_barrier_depends is not sufficient to ensure
> loads following it are not speculatively loaded out of order
> by the CPU, which can result in stale data being loaded, causing
> potential system crashes.

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
