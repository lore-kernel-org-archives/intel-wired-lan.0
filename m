From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Fri, 10 Apr 2015 12:39:00 -0700
Subject: [Intel-wired-lan] [PATCH 2/2 net-next] net_device: Reorder
	members to fill holes
In-Reply-To: <1df55f36edb4bd47a051e2664d243a3e91d29fb4.1428672434.git.tgraf@suug.ch>
References: <cover.1428672434.git.tgraf@suug.ch>
 <1df55f36edb4bd47a051e2664d243a3e91d29fb4.1428672434.git.tgraf@suug.ch>
Message-ID: <1428694740.25985.327.camel@edumazet-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-10 at 15:52 +0200, Thomas Graf wrote:
> Some trivial reorders while preserving the RX/TX cache lines
> split to fill a couple of holes.
> 
> Signed-off-by: Thomas Graf <tgraf@suug.ch>
> ---
>  include/linux/netdevice.h | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)

Acked-by: Eric Dumazet <edumazet@google.com>

Thanks Thomas !


