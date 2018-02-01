From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 31 Jan 2018 16:49:36 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 01/10] net: Add a new socket
 option for a future transmit time.
In-Reply-To: <20180118171335.bhyl76wobdffedho@localhost>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
 <20180117230621.26074-2-jesus.sanchez-palencia@intel.com>
 <20180118084227.GL1175@localhost> <20180118171335.bhyl76wobdffedho@localhost>
Message-ID: <8e77a23e-d8f8-78ee-f681-0aa689ba3d22@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


On 01/18/2018 09:13 AM, Richard Cochran wrote:
> On Thu, Jan 18, 2018 at 09:42:27AM +0100, Miroslav Lichvar wrote:
>> In the discussion about the v1 patchset, there was a question if the
>> cmsg should include a clockid_t. Without that, how can an application
>> prevent the packet from being sent using an incorrect clock, e.g.
>> the system clock when it expects it to be a PHC, or a different PHC
>> when the socket is not bound to a specific interface?
> 
> Right, the clockid_t should be passed in through the CMSG along with
> the time.

While implementing this today it crossed my mind that why don't we have the
clockid_t set per socket (e.g. as an argument to SO_TXTIME) instead of per packet?

The only use-case that we could think of that would be 'blocked' was using
sendmmsg() to send a packet to different interfaces with a single syscall, but
I'm not sure how common that is.

What do you think?

Thanks,
Jesus


>  
> Thanks,
> Richard
> 
