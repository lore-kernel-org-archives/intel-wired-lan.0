From: David Miller <davem@davemloft.net>
Date: Wed, 03 Jun 2015 23:57:51 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] fm10k: Fix missing braces after if
	statement
In-Reply-To: <20150604015219.2895.80478.stgit@ahduyck-vm-fedora22>
References: <20150604015219.2895.80478.stgit@ahduyck-vm-fedora22>
Message-ID: <20150603.235751.1703498220892447151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Wed, 03 Jun 2015 18:53:17 -0700

> While reviewing the code I noticed that one of the commits added an if
> statement followed by a for loop, but the if statement was missing the
> braces around the loop.  This change corrects the coding style error.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>

I assume that I will get this via Jeff.
