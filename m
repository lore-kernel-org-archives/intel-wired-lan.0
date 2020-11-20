From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 20 Nov 2020 10:53:44 -0800
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
Message-ID: <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:
> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.
> 
> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> add multiple break/goto/return/fallthrough statements instead of just
> letting the code fall through to the next case.
> 
> Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> change[1] is meant to be reverted at some point. So, this patch helps
> to move in that direction.
> 
> Something important to mention is that there is currently a discrepancy
> between GCC and Clang when dealing with switch fall-through to empty case
> statements or to cases that only contain a break/continue/return
> statement[2][3][4].

Are we sure we want to make this change? Was it discussed before?

Are there any bugs Clangs puritanical definition of fallthrough helped
find?

IMVHO compiler warnings are supposed to warn about issues that could
be bugs. Falling through to default: break; can hardly be a bug?!
