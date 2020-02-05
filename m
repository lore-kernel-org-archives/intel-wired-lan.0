From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 5 Feb 2020 11:03:49 -0800
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Complete to commit Add
 support for TSO
In-Reply-To: <20200205123115.44103-1-sasha.neftin@intel.com>
References: <20200205123115.44103-1-sasha.neftin@intel.com>
Message-ID: <20200205110242.000060ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 5 Feb 2020 14:31:15 +0200 Sasha wrote:
> commit f38b782dccab ("igc: Add support for TSO")

is that a Fixes tag?

> Add option to setting transmit command (TUCMD) of the context
> descriptor based on skb_shinfo gso_type and SKB_GSO_UDP_L4 flag.

You said what you did but not why.
