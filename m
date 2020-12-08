From: David Ahern <dsahern@gmail.com>
Date: Mon, 7 Dec 2020 18:01:00 -0700
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com> <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
Message-ID: <431a53bd-25d7-8535-86e1-aa15bf94e6c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/7/20 1:52 PM, John Fastabend wrote:
>>
>> I think we need to keep XDP_TX action separate, because I think that
>> there are use-cases where the we want to disable XDP_TX due to end-user
>> policy or hardware limitations.
> 
> How about we discover this at load time though. Meaning if the program
> doesn't use XDP_TX then the hardware can skip resource allocations for
> it. I think we could have verifier or extra pass discover the use of
> XDP_TX and then pass a bit down to driver to enable/disable TX caps.
> 

This was discussed in the context of virtio_net some months back - it is
hard to impossible to know a program will not return XDP_TX (e.g., value
comes from a map).

Flipping that around, what if the program attach indicates whether
XDP_TX could be returned. If so, driver manages the resource needs. If
not, no resource needed and if the program violates that and returns
XDP_TX the packet is dropped.
