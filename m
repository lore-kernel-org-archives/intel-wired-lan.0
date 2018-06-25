From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Sun, 24 Jun 2018 20:11:59 -0700
Subject: [Intel-wired-lan] [patch net-next 2/3] nfp: handle cls_flower
 command default case
In-Reply-To: <20180624083839.1692-3-jiri@resnulli.us>
References: <20180624083839.1692-1-jiri@resnulli.us>
 <20180624083839.1692-3-jiri@resnulli.us>
Message-ID: <20180624201159.06bad599@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 24 Jun 2018 10:38:38 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@mellanox.com>
> 
> Currently the default case is not handled, which with future command
> introductions would introduce a warning. So handle it.
> 
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
