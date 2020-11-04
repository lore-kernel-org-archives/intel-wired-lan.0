From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 4 Nov 2020 15:35:07 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 1/6] i40e: introduce lazy Tx
 completions for AF_XDP zero-copy
In-Reply-To: <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
 <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20201104153507.5df7c8d6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 4 Nov 2020 15:33:20 -0800 Jakub Kicinski wrote:
> I feel like this needs a big fat warning somewhere.
> 
> It's perfectly fine to never complete TCP packets,

s/TCP/normal XDP/, sorry

> but AF_XDP could be used to implement protocols in user space. What
> if someone wants to implement something like TSQ?

