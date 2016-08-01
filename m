From: David Miller <davem@davemloft.net>
Date: Sun, 31 Jul 2016 20:47:59 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 1/1] net: i10e: use matching format
	indentifiers
In-Reply-To: <1469957968-726-1-git-send-email-xypron.glpk@gmx.de>
References: <1469957968-726-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160731.204759.1283451349474511870.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Sun, 31 Jul 2016 11:39:28 +0200

> i is defined as int but output as %u several times.
> Change the definition to unsigned.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

I hate changes like this.

The canonical way to loop over a value is to use a signed integer,
named 'i', and go:

	for (i = 0; i < X; i ++)

'i' can never be negative, therefore we know that this usage
is safe.

I'd rather you convert the "%u" to "%d".

I'm very disappointed in your patches, and it is clear you
are just finding the easiest and simplest way to shut up
compiler warnings you are seeing rather than analyzing the
code you are making changes to in order to determine what
the best and most appropriate fix might be.
