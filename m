From: Julia Lawall <julia.lawall@lip6.fr>
Date: Mon, 22 Apr 2019 16:47:49 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v2 48/79] docs: driver-model: convert
 docs to ReST and rename to *.rst
In-Reply-To: <dbd6b1ffee1bc31c89d0816588f13a7f91bc9f66.1555938376.git.mchehab+samsung@kernel.org>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
 <dbd6b1ffee1bc31c89d0816588f13a7f91bc9f66.1555938376.git.mchehab+samsung@kernel.org>
Message-ID: <alpine.DEB.2.21.1904221647060.2458@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
> index b2a2cf8bf81f..e32236a979a8 100644
> --- a/scripts/coccinelle/free/devm_free.cocci
> +++ b/scripts/coccinelle/free/devm_free.cocci
> @@ -2,7 +2,7 @@
>  /// functions.  Values allocated using the devm_functions are freed when
>  /// the device is detached, and thus the use of the standard freeing
>  /// function would cause a double free.
> -/// See Documentation/driver-model/devres.txt for more information.
> +/// See Documentation/driver-model/devres.rst for more information.
>  ///
>  /// A difficulty of detecting this problem is that the standard freeing
>  /// function might be called from a different function than the one

Acked-by: Julia Lawall <julia.lawall@lip6.fr>



> --
> 2.20.1
>
>
