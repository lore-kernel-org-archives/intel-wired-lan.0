From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 10 Nov 2015 08:27:49 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3] fm10k: correctly pack
 TLV structures and explain reasoning
In-Reply-To: <1447106648-5591-1-git-send-email-jacob.e.keller@intel.com>
References: <1447106648-5591-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1447172869.4094.25.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-11-09 at 14:04 -0800, Jacob Keller wrote:
> The TLV format for little endian structures is actually 4 byte
> aligned
> copy. To this end, we need to add an additional __aligned(4) marker
> along with __packed to ensure that these structures are actually 4
> byte
> aligned and packed correctly. Use of just __packed will not work as
> this
> will result in 1byte alignment which is incorrect. Add a comment
> explaining the reasoning behind why these structures need the special
> treatment.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> - v3
> * use __aligned(4) instead of __attribute__(aligned(4))
> 
> Note: this patch replaces both TLV patches currently on the queue as
> it
> looks like Jeff had forgotten to remove the earlier one when the
> subject
> changed.

Nope, I just applied the last submitted version of this patch. ?Might
be helpful if the version actually incremented when you re-submit a
patch. ?This is the third version of "v3", so techincally this should
have been v5. :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151110/7cf5337d/attachment.asc>
