class ReviewsController < ApplicationController
  before_action :set_review, only: [ :edit, :update, :destroy ]

  def create
    @property = Property.find(params[:property_id])
    @review = @property.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @property, notice: "Thanks for your review."
    else
      redirect_to @property, alert: @review.errors.full_messages.to_sentence, status: :see_other
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review.property, notice: "Review updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to @review.property, notice: "Review deleted.", status: :see_other
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.expect(review: [ :visit_id, :rating, :comment ])
  end
end
