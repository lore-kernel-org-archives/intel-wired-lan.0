From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 21 Jun 2019 15:47:40 +0200
Subject: [Intel-wired-lan] [PATCH v2 09/29] docs: driver-model: convert
 docs to ReST and rename to *.rst
In-Reply-To: <0ac41c7d682452cdbd867c4ae7729b6b34d79c0b.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
 <0ac41c7d682452cdbd867c4ae7729b6b34d79c0b.1560890800.git.mchehab+samsung@kernel.org>
Message-ID: <20190621134740.GA26549@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 18, 2019 at 05:53:27PM -0300, Mauro Carvalho Chehab wrote:
> Convert the various documents at the driver-model, preparing
> them to be part of the driver-api book.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com> # ice

Now applied, thanks.

greg k-h
