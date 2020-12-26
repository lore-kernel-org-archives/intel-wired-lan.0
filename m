From: Joe Perches <joe@perches.com>
Date: Sat, 26 Dec 2020 09:47:19 -0800
Subject: [Intel-wired-lan] [PATCH] ethernet: Remove invalid trailers
 after %pI4
In-Reply-To: <d1ea50ed47e2e9ca65a67ffc2ca0eee08e662132.camel@perches.com>
References: <d1ea50ed47e2e9ca65a67ffc2ca0eee08e662132.camel@perches.com>
Message-ID: <0d06aad61cdb5be1d9c8c17bcf938d726d028e3f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2020-12-26 at 09:10 -0800, Joe Perches wrote:
> Alphanumeric characters after vsprintf pointer extension %pI4 are
> not valid and are not emitted.
> 
> Remove the invalid characters from the %pI4 uses.

self-nak.  I believe I misunderstood the format specifier.


