From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 14 Nov 2018 17:04:53 -0800
Subject: [Intel-wired-lan] [PATCH] igb: Fix format with line
 continuation whitespace
In-Reply-To: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
References: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
Message-ID: <878t1v2lsa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Joe Perches <joe@perches.com> writes:

> The line continuation unintentionally adds whitespace so
> instead use a coalesced format to remove the whitespace.
>
> Miscellanea:
>
> o Use a more typical style for ternaries and arguments
>   for this logging message
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
--
Vinicius
