From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 24 Apr 2015 18:25:07 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] igb/fm10k/ixgbevf: Drop
 XXX_pull_tail and pull header in XXX_add_rx_frag
In-Reply-To: <20150423040941.18903.3545.stgit@ahduyck-vm-fedora22>
References: <20150423040941.18903.3545.stgit@ahduyck-vm-fedora22>
Message-ID: <1429925107.2644.64.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-04-22 at 21:49 -0700, Alexander Duyck wrote:
> These three patches remove the _pull_tail functions for the drivers
> igb,
> fm10k, and ixgbevf in favor of simply pulling the header in all cases
> at
> the start of _add_rx_frag.
> 
> For igb this might be considered a driver fix, but the issue would be
> a
> corner case in which timestamping is enabled, a packet is received
> that is 
> between 241 and 255 bytes in size, and the header contains bad data
> which 
> places its size something greater than the actual size.
> 
> The ixgbe driver is excluded from this set as it cannot support this
> due to
> RSC overwriting the header data until the EOP and DD bit are written
> in the
> last descriptor.

Thanks Alex, applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150424/c95f1b2d/attachment-0001.asc>
