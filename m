From: David Ahern <dsahern@gmail.com>
Date: Wed, 9 Dec 2020 08:44:33 -0700
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <20201209125223.49096d50@carbon>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com> <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
 <20201209125223.49096d50@carbon>
Message-ID: <6913010d-2fd6-6713-94e9-8f5b8ad4b708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/9/20 4:52 AM, Jesper Dangaard Brouer wrote:
> But I have redesigned the ndo_xdp_xmit call to take a bulk of packets
> (up-to 16) so it should not be a problem to solve this by sharing
> TX-queue and talking a lock per 16 packets.  I still recommend that,
> for fallback case,  you allocated a number a TX-queue and distribute
> this across CPUs to avoid hitting a congested lock (above measurements
> are the optimal non-congested atomic lock operation)

I have been meaning to ask you why 16 for the XDP batching? If the
netdev budget is 64, why not something higher like 32 or 64?
