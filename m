From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 18 May 2016 14:27:58 -0700
Subject: [Intel-wired-lan] [net-next PATCH 0/2] Follow-ups for GUEoIPv6
	patches
In-Reply-To: <20160518173605.2608.42484.stgit@localhost.localdomain>
References: <20160518173605.2608.42484.stgit@localhost.localdomain>
Message-ID: <1463606878.2713.68.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-05-18 at 10:44 -0700, Alexander Duyck wrote:
> This patch series is meant to be applied after:
> [PATCH v7 net-next 00/16] ipv6: Enable GUEoIPv6 and more fixes for v6
> tunneling
> 
> The first patch addresses an issue we already resolved in the GREv4 and
> is
> now present in GREv6 with the introduction of FOU/GUE for IPv6 based GRE
> tunnels.
> 
> The second patch goes through and enables IPv6 tunnel offloads for the
> Intel
> NICs that already support the IPv4 based IP-in-IP tunnel offloads.? I
> have
> only done a bit of touch testing but have seen ~20 Gb/s over an i40e
> interface using a v4-in-v6 tunnel, and I have verified IPv6 GRE is still
> passing traffic at around the same rate.? I plan to do further testing
> but
> with these patches present it should enable a wider audience to be able
> to
> test the new features introduced in Tom's patchset with hardware
> offloads.
> 
> ---
> 
> Alexander Duyck (2):
> ????? ip6_gre: Do not allow segmentation offloads GRE_CSUM is enabled
> with FOU/GUE
> ????? intel: Add support for IPv6 IP-in-IP offload

Dave, I have this series added to my queue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160518/c432c17a/attachment-0001.asc>
