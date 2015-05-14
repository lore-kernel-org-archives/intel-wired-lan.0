From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 14 May 2015 23:16:34 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add array of MAC
	type	dependent values
In-Reply-To: <20150514221630.16569.73269.stgit@dcs-desk.jf.intel.com>
References: <20150514221630.16569.73269.stgit@dcs-desk.jf.intel.com>
Message-ID: <0F572F3A-8E41-44FD-9858-FFFC8906BF37@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It seems like there are consts missing here. I would expect all of the new ixgbe_mvals_* arrays to be const because they are never written to.

Actually, it seems like the ixgbe_*_info structures should also be const, but I haven't verified that. I'm quite sure about the ixgbe_mvals_* arrays.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150514/b9af4ae7/attachment.asc>
