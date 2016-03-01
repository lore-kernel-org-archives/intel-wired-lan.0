From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 19:10:39 +0000
Subject: [Intel-wired-lan] [next PATCH 3/3] ixgbe: Fix ATR so that it
 correctly handles IPv6 extension headers
In-Reply-To: <20160126033635.16387.56585.stgit@localhost.localdomain>
References: <20160126032616.16387.86351.stgit@localhost.localdomain>
 <20160126033635.16387.56585.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C17C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, January 25, 2016 7:40 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH 3/3] ixgbe: Fix ATR so that it correctly
> handles IPv6 extension headers
> 
> The ATR code was assuming that it would be able to use tcp_hdr for every
> TCP frame that came through.  However this isn't the case as it is possible for
> a frame to arrive that is TCP but sent through something like a raw socket.  As
> a result the driver was setting up bad filters in which tcp_hdr was really
> pointing to the network header so the data was all invalid.
> 
> In order to correct this I have added a bit of parsing logic that will determine
> the TCP header location based off of the network header and either the
> offset in the case of the IPv4 header, or a walk through the
> IPv6 extension headers until it encounters the header that indicates
> IPPROTO_TCP.  In addition I have added checks to verify that the lowest
> protocol provided is recognized as IPv4 or IPv6 to help mitigate raw sockets
> using ETH_P_ALL from having ATR applied to them.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> 
> ---
> 
> Testing Hints:
> In order for me to verify the bug was there I ended up having to use tools
> such as tcpreplay and some raw socket apps to send TCP frames.  Without
> instrumenting the driver this can be hard to see.  One approach might be to
> enable 9K jumbo frames between two hosts and then start using TCP replay
> or something similar to start walking through the same port and IP numbers,
> but sending larger and larger packets.  On a system without this patch you
> should see the following behavior:
>   1.  IP total length is interpreted as destination port
>   2.  Second octet of IP source address is interpreted as TCP flags.
>       - Fin resides at bit 0, so odd values will not cause issue.
>       - Syn is in second bit, so it is 20X more likely to cause issue
>         - In other words test with 190.2.100.X, not 190.1.100.X
> 
> Testing with a range of frame sizes should start triggering table resets
> without any flow director matches due to how the headers are being
> misread.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   45 ++++++++++++---------
> ----
>  1 file changed, 21 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Traffic handled correctly IPv4/v6
