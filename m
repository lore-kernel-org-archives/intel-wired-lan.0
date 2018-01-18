From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 18 Jan 2018 09:13:35 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180118084227.GL1175@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost>
Message-ID: <20180118171335.bhyl76wobdffedho@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 18, 2018 at 09:42:27AM +0100, Miroslav Lichvar wrote:
> In the discussion about the v1 patchset, there was a question if the
> cmsg should include a clockid_t. Without that, how can an application
> prevent the packet from being sent using an incorrect clock, e.g.
> the system clock when it expects it to be a PHC, or a different PHC
> when the socket is not bound to a specific interface?

Right, the clockid_t should be passed in through the CMSG along with
the time.
 
Thanks,
Richard
