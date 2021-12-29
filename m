From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 Dec 2021 09:20:12 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next v2] net: don't include
 filter.h from net/sock.h
In-Reply-To: <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
References: <20211229004913.513372-1-kuba@kernel.org>
 <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
Message-ID: <20211229092012.635e9f2b@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 28 Dec 2021 17:33:39 -0800 Florian Fainelli wrote:
> It would be nice if we used the number of files rebuilt because of a 
> header file change as another metric that the kernel is evaluated with 
> from release to release (or even on a commit by commit basis). Food for 
> thought.

Maybe Andy has some thoughts, he has been working on dropping
unnecessary includes of kernel.h, it seems.

It'd be cool to plug something that'd warn us about significant
increases in dependencies into the patchwork build bot.

I have one more small series which un-includes uapi/bpf.h from
netdevice.h at which point I hope we'll be largely in the clear 
from build bot performance perspective.
