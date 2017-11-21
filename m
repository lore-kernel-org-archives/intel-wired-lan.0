From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 21 Nov 2017 09:36:48 -0800
Subject: [Intel-wired-lan] [PATCH v2 1/7] ixgbe: Fix skb list corruption
 on Power systems
In-Reply-To: <1510938349-17608-2-git-send-email-brking@linux.vnet.ibm.com>
References: <1510938349-17608-1-git-send-email-brking@linux.vnet.ibm.com>
 <1510938349-17608-2-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <20171121093648.00007b98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 17 Nov 2017 11:05:43 -0600
Brian King <brking@linux.vnet.ibm.com> wrote:

> This patch fixes an issue seen on Power systems with ixgbe which results
> in skb list corruption and an eventual kernel oops. The following is what
> was observed:

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
