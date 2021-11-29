From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Mon, 29 Nov 2021 15:29:07 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/2] igc: driver change to
 support XDP metadata
In-Reply-To: <20211129141047.8939-1-alexandr.lobakin@intel.com>
References: <163700856423.565980.10162564921347693758.stgit@firesoul>
 <20211129141047.8939-1-alexandr.lobakin@intel.com>
Message-ID: <de14fefc-a8c1-ff6c-5354-8cce4a3f66f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 29/11/2021 15.10, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> Date: Mon, 15 Nov 2021 21:36:20 +0100
> 
>> Changes to fix and enable XDP metadata to a specific Intel driver igc.
>> Tested with hardware i225 that uses driver igc, while testing AF_XDP
>> access to metadata area.
> 
> Would you mind if I take this your series into my bigger one that
> takes care of it throughout all the Intel drivers?

I have a customer that depend on this fix.  They will have to do the 
backport anyway (to v5.13), but it would bring confidence on their side 
if the commits appear in an official git-tree before doing the backport 
(and optimally with a SHA they can refer to).

Tony Nguyen have these landed in your git-tree?

--JEsper

