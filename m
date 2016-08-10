From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 10 Aug 2016 10:50:48 -0700
Subject: [Intel-wired-lan] [PATCH 1/1 v2] net: i10e: use matching format
	indentifiers
In-Reply-To: <1470161718-8824-1-git-send-email-xypron.glpk@gmx.de>
References: <20160731.204759.1283451349474511870.davem@davemloft.net>
 <1470161718-8824-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <1470851448.2128.15.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-08-02 at 20:15 +0200, Heinrich Schuchardt wrote:
> i is defined as int but output as %u several times.
> Adjust the format identifiers.
> 
> v2:
> ????????Keep definition of i as int.
> ????????David indicated that this is the preferable way to define
> ????????loop variables.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 26 +++++++++++++-------
> ------
> ?1 file changed, 13 insertions(+), 13 deletions(-)

your title needs fixing as well...
s/i10e/i40e/ and s/indentifiers/identifiers/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160810/b07485f8/attachment.asc>
